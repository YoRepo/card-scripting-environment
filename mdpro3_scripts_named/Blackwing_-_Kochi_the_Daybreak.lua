--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 黑羽-东云之东风  (ID: 41902352)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Winged Beast
-- Level 4
-- ATK 700 | DEF 1500
-- Setcode: 51
--
-- Effect Text:
-- 特殊召唤的这张卡不能作为同调素材。
--[[ __CARD_HEADER_END__ ]]

--BF－東雲のコチ
function c41902352.initial_effect(c)
	--synchro limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e1:SetCondition(c41902352.synlimit)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_COST)
	e2:SetCost(c41902352.spcost)
	c:RegisterEffect(e2)
end
function c41902352.synlimit(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c41902352.spcost(e,c,tp,sumtype)
	return sumtype~=SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SYNCHRO_MATERIAL
end
