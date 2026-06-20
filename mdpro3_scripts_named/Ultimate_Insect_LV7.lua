--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 究极昆虫 LV7  (ID: 19877898)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level 7
-- ATK 2600 | DEF 1200
-- Setcode: 65
--
-- Effect Text:
-- 「究极昆虫 LV5」的效果特殊召唤的场合，只要这张卡在自己场上存在，对方的全部怪兽攻击力·守备力下降700。
--[[ __CARD_HEADER_END__ ]]

--アルティメット・インセクト LV7
function c19877898.initial_effect(c)
	--atk,def down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c19877898.con)
	e1:SetValue(-700)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
c19877898.lvup={34830502}
c19877898.lvdn={49441499,34088136,34830502}
function c19877898.con(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_LV
end
