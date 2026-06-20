--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 暗黑之侵略者  (ID: 56647086)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 2900 | DEF 2500
--
-- Effect Text:
-- 只要这张卡在自己场上以表侧表示存在，对方不能发动速攻魔法卡。
--[[ __CARD_HEADER_END__ ]]

--暗黒の侵略者
function c56647086.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c56647086.aclimit)
	c:RegisterEffect(e1)
end
function c56647086.aclimit(e,re,tp)
	return re:GetHandler():GetType()==TYPE_SPELL+TYPE_QUICKPLAY and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
