--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 炎狱魔术师  (ID: 95621257)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Spellcaster
-- Level 4
-- ATK 1400 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- 只要自己场上有名字带有「正义盟军」的怪兽存在，这张卡的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--フレムベル・マジカル
function c95621257.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c95621257.atkcon)
	e1:SetValue(400)
	c:RegisterEffect(e1)
end
function c95621257.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1)
end
function c95621257.atkcon(e)
	return Duel.IsExistingMatchingCard(c95621257.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
