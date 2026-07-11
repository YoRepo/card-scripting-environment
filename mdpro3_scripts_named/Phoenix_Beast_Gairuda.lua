--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Phoenix Beast Gairuda  (ID: 43791861)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 6
-- ATK 2500 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks an opponent's monster, this card gains 300 ATK during the Damage Step only.
--[[ __CARD_HEADER_END__ ]]

--鳳王獣ガイルーダ
function c43791861.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c43791861.condtion)
	e1:SetValue(300)
	c:RegisterEffect(e1)
end
function c43791861.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL)
		and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil
end
