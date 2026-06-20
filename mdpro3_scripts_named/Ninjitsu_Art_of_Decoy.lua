--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 忍法 空蝉之术  (ID: 89628781)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 97
--
-- Effect Text:
-- 选择自己场上的名字有「忍者」字样的1只怪兽才能发动。只要这张卡在场上存在，被选择的怪兽不会被战斗破坏（伤害计算适用）。
--[[ __CARD_HEADER_END__ ]]

--忍法 空蝉の術
function c89628781.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c89628781.target)
	e1:SetOperation(c89628781.operation)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_TARGET)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c89628781.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c89628781.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c89628781.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c89628781.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c89628781.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c89628781.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
	end
end
