--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 连弹之魔术师  (ID: 6337436)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 152
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，每次自己发动通常魔法卡，给与对方基本分400分的伤害。
--[[ __CARD_HEADER_END__ ]]

--連弾の魔術師
function c6337436.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c6337436.damop)
	c:RegisterEffect(e1)
end
function c6337436.damop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetActiveType()==TYPE_SPELL and re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp==tp then
		Duel.Damage(1-tp,400,REASON_EFFECT)
	end
end
