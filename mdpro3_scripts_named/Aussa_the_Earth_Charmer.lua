--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 地灵使 奥丝  (ID: 37970940)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Spellcaster
-- Level 3
-- ATK 500 | DEF 1500
-- Setcode: 191
--
-- Effect Text:
-- ①：这张卡反转的场合，以对方场上1只地属性怪兽为对象发动。这只怪兽表侧表示存在期间，得到作为对象的怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--地霊使いアウス
function c37970940.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37970940,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c37970940.target)
	e1:SetOperation(c37970940.operation)
	c:RegisterEffect(e1)
end
function c37970940.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_EARTH) and c:IsAbleToChangeControler()
end
function c37970940.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c37970940.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c37970940.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c37970940.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e)
		and not tc:IsImmuneToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_CONTROL)
		e1:SetValue(tp)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c37970940.ctcon)
		tc:RegisterEffect(e1)
	end
end
function c37970940.ctcon(e)
	local c=e:GetOwner()
	local h=e:GetHandler()
	return c:IsHasCardTarget(h)
end
