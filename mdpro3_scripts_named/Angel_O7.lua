--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 天使O7  (ID: 56784842)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 2500 | DEF 1500
--
-- Effect Text:
-- 这张卡的祭品召唤成功时，这张卡得到以下效果。
-- ●只要这张卡在场上表侧表示存在，效果怪兽不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--エンジェルO7
function c56784842.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c56784842.regop)
	c:RegisterEffect(e1)
end
function c56784842.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsSummonType(SUMMON_TYPE_ADVANCE) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c56784842.aclimit)
	c:RegisterEffect(e1)
end
function c56784842.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
