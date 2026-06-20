--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 电脑堺甲-甲甲  (ID: 90664857)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Wyrm
-- Rank 3
-- ATK 1000 | DEF 2400
-- Setcode: 334
--
-- Effect Text:
-- 3星怪兽×2只以上
-- ①：1回合1次，把这张卡1个超量素材取除，以自己场上1只表侧表示怪兽为对象才能发动。那只怪兽直到对方回合结束时不会被战斗破坏。
-- ②：1回合1次，原本的种族·属性相同的怪兽在自己墓地有2只以上存在，这张卡和对方怪兽进行战斗的伤害计算后才能发动。那只对方怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--電脳堺甲－甲々
function c90664857.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,3,2,nil,nil,99)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90664857,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c90664857.cost)
	e1:SetTarget(c90664857.target)
	e1:SetOperation(c90664857.operation)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90664857,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCountLimit(1)
	e2:SetCondition(c90664857.rmcon)
	e2:SetTarget(c90664857.rmtg)
	e2:SetOperation(c90664857.rmop)
	c:RegisterEffect(e2)
end
function c90664857.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c90664857.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c90664857.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
	end
end
function c90664857.rmfilter(c,g)
	return g:IsExists(c90664857.rmfilter2,1,c,c)
end
function c90664857.rmfilter2(c,tc)
	return c:GetOriginalRace()&tc:GetOriginalRace()~=0
		and c:GetOriginalAttribute()&tc:GetOriginalAttribute()~=0
end
function c90664857.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabelObject(bc)
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	return bc and bc:IsStatus(STATUS_OPPO_BATTLE) and bc:IsRelateToBattle() and g:IsExists(c90664857.rmfilter,1,nil,g)
end
function c90664857.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return bc:IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,bc,1,0,0)
end
function c90664857.rmop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end
