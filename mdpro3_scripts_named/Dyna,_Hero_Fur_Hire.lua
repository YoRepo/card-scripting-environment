--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 空牙团的豪杰 戴纳  (ID: 25123713)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 6
-- ATK 2500 | DEF 1400
-- Setcode: 276
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合才能发动。选最多有自己场上的「空牙团」怪兽种类数量的对方墓地的卡除外。
-- ②：只要这张卡在怪兽区域存在，对方不能选择其他的「空牙团」怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--空牙団の豪傑 ダイナ
function c25123713.initial_effect(c)
	--banish
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,25123713)
	e1:SetTarget(c25123713.rmtg)
	e1:SetOperation(c25123713.rmop)
	c:RegisterEffect(e1)
	--atk limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c25123713.atlimit)
	c:RegisterEffect(e2)
end
function c25123713.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x114)
end
function c25123713.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c25123713.filter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return g:GetCount()~=0
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_GRAVE)
end
function c25123713.rmop(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.GetMatchingGroup(c25123713.filter,tp,LOCATION_MZONE,0,nil)
	local ct=cg:GetClassCount(Card.GetCode)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,ct,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
function c25123713.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x114) and c~=e:GetHandler()
end
