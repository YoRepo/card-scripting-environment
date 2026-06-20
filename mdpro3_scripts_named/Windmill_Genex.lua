--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 次世代风能人  (ID: 43925870)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Machine
-- Level 7
-- ATK 2000 | DEF 1600
-- Setcode: 2
--
-- Effect Text:
-- 「次世代控制员」＋调整以外的风属性怪兽1只以上
-- ①：这张卡的攻击力上升场上的里侧表示的魔法·陷阱卡数量×300。
-- ②：把1张手卡送去墓地，以场上1张里侧表示的魔法·陷阱卡为对象才能发动。那张里侧表示卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ウィンドファーム・ジェネクス
function c43925870.initial_effect(c)
	aux.AddMaterialCodeList(c,68505803)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsCode,68505803),aux.NonTuner(Card.IsAttribute,ATTRIBUTE_WIND),1)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c43925870.val)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43925870,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c43925870.descost)
	e2:SetTarget(c43925870.destg)
	e2:SetOperation(c43925870.desop)
	c:RegisterEffect(e2)
end
function c43925870.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsFacedown,0,LOCATION_SZONE,LOCATION_SZONE,nil)*300
end
function c43925870.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	Duel.SendtoGrave(Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,1,nil),REASON_COST)
end
function c43925870.filter(c)
	return c:IsFacedown()
end
function c43925870.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c43925870.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c43925870.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c43925870.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c43925870.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
