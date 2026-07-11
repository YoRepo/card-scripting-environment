--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Prank-Kids Meow-Meow-Mu  (ID: 25725326)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Rock
-- Link Rating: 1
-- Link Arrows: Bottom
-- ATK 1000
-- Setcode: 0x120
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Level 4 or lower "Prank-Kids" monster
-- You can only Link Summon "Prank-Kids Meow-Meow-Mu" once per turn.
-- If a "Prank-Kids" monster you control would Tribute itself to activate its effect during your
-- opponent's turn, you can banish this card you control or from your GY instead.
-- You can only use this effect of "Prank-Kids Meow-Meow-Mu" once per turn.
--[[ __CARD_HEADER_END__ ]]

--プランキッズ・ミュー
function c25725326.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c25725326.mfilter,1,1)
	c:EnableReviveLimit()
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c25725326.regcon)
	e1:SetOperation(c25725326.regop)
	c:RegisterEffect(e1)
	--release replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(25725326)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCountLimit(1,25725326)
	e2:SetCondition(c25725326.repcon)
	c:RegisterEffect(e2)
end
function c25725326.mfilter(c)
	return c:IsLevelBelow(4) and c:IsLinkSetCard(0x120)
end
function c25725326.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c25725326.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c25725326.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c25725326.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsCode(25725326) and bit.band(sumtype,SUMMON_TYPE_LINK)==SUMMON_TYPE_LINK
end
function c25725326.repcon(e)
	return Duel.GetTurnPlayer()==1-e:GetHandlerPlayer()
end
