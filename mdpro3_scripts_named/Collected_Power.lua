--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 力之集约  (ID: 7565547)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择场上表侧表示存在的1只怪兽发动。场上存在的全部装备卡给选择的怪兽装备。对象不正确的装备卡破坏。
--[[ __CARD_HEADER_END__ ]]

--力の集約
function c7565547.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c7565547.target)
	e1:SetOperation(c7565547.operation)
	c:RegisterEffect(e1)
end
function c7565547.eqfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EQUIP)
end
function c7565547.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c7565547.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c7565547.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local dg=Group.CreateGroup()
	local g=Duel.GetMatchingGroup(c7565547.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	local ec=g:GetFirst()
	while ec do
		if tc:IsFaceup() and tc:IsRelateToEffect(e) and ec:CheckEquipTarget(tc) then
			Duel.Equip(tp,ec,tc,false,false)
		else
			dg:AddCard(ec)
		end
		ec=g:GetNext()
	end
	Duel.EquipComplete()
	Duel.Destroy(dg,REASON_EFFECT)
end
