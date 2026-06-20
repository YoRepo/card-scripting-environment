--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 红衣忍者  (ID: 14618326)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Warrior
-- Level 1
-- ATK 300 | DEF 300
-- Setcode: 43
--
-- Effect Text:
-- ①：这张卡反转的场合，以场上1张表侧表示的陷阱卡或者场上盖放的1张魔法·陷阱卡为对象发动。那张陷阱卡破坏（那张卡在场上盖放中的场合，翻开确认）。
--[[ __CARD_HEADER_END__ ]]

--赤い忍者
function c14618326.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14618326,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c14618326.target)
	e1:SetOperation(c14618326.operation)
	c:RegisterEffect(e1)
end
function c14618326.filter(c)
	return c:IsType(TYPE_TRAP) or (c:IsFacedown() and c:IsLocation(LOCATION_SZONE) and c:GetSequence()~=5)
end
function c14618326.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c14618326.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c14618326.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 and g:GetFirst():IsFaceup() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c14618326.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
		if tc:IsType(TYPE_TRAP) then Duel.Destroy(tc,REASON_EFFECT) end
	end
end
