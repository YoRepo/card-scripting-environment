--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 地狱的番熊  (ID: 75375465)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level 4
-- ATK 1300 | DEF 1800
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，自己场上的「万魔殿-恶魔的巢窟-」不会被对方所控制的卡的效果所破坏。
--[[ __CARD_HEADER_END__ ]]

--地獄の番熊
function c75375465.initial_effect(c)
	aux.AddCodeList(c,94585852)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(c75375465.indtg)
	e1:SetValue(c75375465.indval)
	c:RegisterEffect(e1)
end
function c75375465.indtg(e,c)
	return c:IsFaceup() and c:IsCode(94585852)
end
function c75375465.indval(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end
