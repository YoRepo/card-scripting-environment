--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 鳞粉蛾  (ID: 68087897)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 6
-- ATK 1800 | DEF 2300
--
-- Effect Text:
-- 只要这张卡场上表侧表示存在，双方玩家1回合只能1次把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スケイルモース
function c68087897.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_SPSUMMON_COUNT)
	--spsummon count limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_COUNT_LIMIT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
