--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 秘仪之力1-魔术师  (ID: 8396952)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1100 | DEF 1100
-- Setcode: 5
--
-- Effect Text:
-- 这张卡召唤·反转召唤·特殊召唤成功时，进行1次投掷硬币得到以下效果。
-- ●表：魔法卡发动时，直到那个回合的结束阶段时这张卡的原本攻击力变成2倍。
-- ●里：每次魔法卡发动对方回复500基本分。
--[[ __CARD_HEADER_END__ ]]

--アルカナフォースⅠ－THE MAGICIAN
function c8396952.initial_effect(c)
	--coin
	aux.EnableArcanaCoin(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP_SUMMON_SUCCESS,EVENT_SPSUMMON_SUCCESS)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.ArcanaCondition)
	e1:SetOperation(c8396952.speop)
	c:RegisterEffect(e1)
end
function c8396952.speop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsActiveType(TYPE_SPELL) or not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local val=c:GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)
	if val==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	else
		Duel.Recover(1-tp,500,REASON_EFFECT)
	end
end
