--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Primitive Butterfly  (ID: 98154550)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Insect
-- Level: 5
-- ATK 1200 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control no monsters, you can Special Summon this card (from your hand).
-- Once per turn: You can increase the Levels of all Insect-Type monsters you currently control by 1.
--[[ __CARD_HEADER_END__ ]]

--プリミティブ・バタフライ
function c98154550.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c98154550.spcon)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98154550,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c98154550.target)
	e2:SetOperation(c98154550.operation)
	c:RegisterEffect(e2)
end
function c98154550.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c98154550.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsRace(RACE_INSECT)
end
function c98154550.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c98154550.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c98154550.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c98154550.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
