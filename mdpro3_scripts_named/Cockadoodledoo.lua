--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Cockadoodledoo  (ID: 42338879)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 5
-- ATK 1600 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If there are no monsters on the field, you can Special Summon this card (from your hand) as a Level
-- 3 monster.
-- If your opponent controls a monster and you control no cards, you can Special Summon this card (from
-- your hand) as a Level 4 monster.
-- If this face-up card would leave the field, banish it instead.
--[[ __CARD_HEADER_END__ ]]

--こけコッコ
function c42338879.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c42338879.spcon)
	e1:SetOperation(c42338879.spop)
	c:RegisterEffect(e1)
	--redirect
	aux.AddBanishRedirect(c)
end
function c42338879.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return (Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)==0
		or (Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)==0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0))
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c42338879.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)==0 then
		e1:SetValue(3)
	else
		e1:SetValue(4)
	end
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
