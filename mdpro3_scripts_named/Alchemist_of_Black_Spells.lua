--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑魔力精制者  (ID: 78121572)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 4
-- ATK 1200 | DEF 1800
--
-- Effect Text:
-- ①：1回合1次，以自己场上1张可以放置魔力指示物的卡为对象才能发动。自己场上的攻击表示的这张卡变成表侧守备表示，给作为对象的自己的卡放置1个魔力指示物。
--[[ __CARD_HEADER_END__ ]]

--黒魔力の精製者
function c78121572.initial_effect(c)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78121572,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c78121572.con)
	e1:SetTarget(c78121572.tg)
	e1:SetOperation(c78121572.op)
	c:RegisterEffect(e1)
end
function c78121572.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c78121572.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x1,1)
end
function c78121572.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c78121572.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c78121572.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)
	local g=Duel.SelectTarget(tp,c78121572.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x1)
end
function c78121572.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		if tc:IsRelateToEffect(e) then
			tc:AddCounter(0x1,1)
		end
	end
end
