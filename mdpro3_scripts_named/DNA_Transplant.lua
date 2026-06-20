--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: DNA移植手术  (ID: 56769674)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡发动时，宣言1种属性。这张卡在场上存在时，场上所有表侧表示的怪兽全部变成被宣言的属性。
--[[ __CARD_HEADER_END__ ]]

--DNA移植手術
function c56769674.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c1)
	e1:SetTarget(c56769674.target)
	c:RegisterEffect(e1)
	--race
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e2:SetValue(c56769674.value)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c56769674.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
	local rc=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL)
	e:GetLabelObject():SetLabel(rc)
	e:GetHandler():SetHint(CHINT_ATTRIBUTE,rc)
end
function c56769674.value(e,c)
	return e:GetLabel()
end
