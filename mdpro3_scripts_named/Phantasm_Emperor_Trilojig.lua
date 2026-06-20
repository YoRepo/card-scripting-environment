--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 幻魔帝 三联电子人  (ID: 95463814)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 10
-- ATK 4000 | DEF 4000
-- Setcode: 324
--
-- Effect Text:
-- 10星怪兽×3
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合或者这张卡已在怪兽区域存在的状态有这张卡以外的怪兽从墓地往自己场上特殊召唤的场合，以对方场上1只表侧表示怪兽为对象才能发动。给与对方那只怪兽的原本攻击力一半数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--幻魔帝トリロジーグ
function c95463814.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsLevel,10),3,true)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95463814,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,95463814)
	e1:SetTarget(c95463814.target)
	e1:SetOperation(c95463814.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c95463814.contition2)
	c:RegisterEffect(e2)
end
function c95463814.filter(c)
	return c:IsFaceup() and c:GetBaseAttack()>0
end
function c95463814.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c95463814.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c95463814.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c95463814.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,math.floor(g:GetFirst():GetBaseAttack()/2))
end
function c95463814.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,math.floor(tc:GetBaseAttack()/2),REASON_EFFECT)
	end
end
function c95463814.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_GRAVE) and c:IsControler(tp)
end
function c95463814.contition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return not eg:IsContains(c) and eg:IsExists(c95463814.cfilter,1,nil,tp)
end
