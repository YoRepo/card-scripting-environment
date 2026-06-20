--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 秘仪之力4-皇帝  (ID: 61175706)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1400 | DEF 1400
-- Setcode: 5
--
-- Effect Text:
-- 这张卡召唤·反转召唤·特殊召唤成功时，进行1次投掷硬币得到以下效果。
-- ●表：自己场上表侧表示存在的名字带有「秘仪之力」的怪兽的攻击力上升500。
-- ●里：自己场上表侧表示存在的名字带有「秘仪之力」的怪兽的攻击力下降500。
--[[ __CARD_HEADER_END__ ]]

--アルカナフォースⅣ－THE EMPEROR
function c61175706.initial_effect(c)
	--coin
	aux.EnableArcanaCoin(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP_SUMMON_SUCCESS,EVENT_SPSUMMON_SUCCESS)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(aux.ArcanaCondition)
	e1:SetTarget(c61175706.atktg)
	e1:SetValue(c61175706.atkval)
	c:RegisterEffect(e1)
end
function c61175706.atktg(e,c)
	return c:IsSetCard(0x5)
end
function c61175706.atkval(e,c)
	if e:GetHandler():GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)==1 then
		return 500
	else
		return -500
	end
end
