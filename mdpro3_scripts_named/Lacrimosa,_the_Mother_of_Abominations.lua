--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-21T00:00:00
-- Card: Lacrimosa, the Mother of Abominations  (ID: 211170)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Fiend
-- Level 11
-- ATK 3800 | DEF 2200
-- Setcode: 0x95c (Crimsonheart)
--
-- Effect Text:
-- Must be Special Summoned by the effect of "Crimsonheart Hidden Infant". You can only control 1
-- "Lacrimosa, the Mother of Abominations". You can only use the (1) effect of "Lacrimosa, the Mother
-- of Abominations" once per turn.
-- (1) When your opponent's activated card or effect resolves, you can banish both this card and 1
-- "Crimsonheart Hidden Infant" you control until that effect finishes resolving, then return both to
-- the field, and if you do, you can banish 2 cards from your opponent's field and/or GY.
-- (2) Negate the effect(s) of your opponent's cards in this card's column.
--[[ __CARD_HEADER_END__ ]]

--Lacrimosa, the Mother of Abominations
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,211160)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,id)
	--Must be Special Summoned by "Crimsonheart Hidden Infant" (it summons via nocheck)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.FALSE)
	c:RegisterEffect(e0)
	--(1) when opponent's card/effect resolves: banish this + 1 Hidden Infant until it resolves, then return & banish 2
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(s.rmcon)
	e1:SetOperation(s.rmop)
	c:RegisterEffect(e1)
	--(2) negate the effects of opponent's cards in this card's column
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE+LOCATION_SZONE)
	e2:SetTarget(s.discol)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_DISABLE_EFFECT)
	c:RegisterEffect(e3)
end
--(1)
function s.hifilter(c)
	return c:IsCode(211160) and c:IsAbleToRemove()
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and re:GetHandler()~=c
		and c:GetFlagEffect(id)==0
		and c:IsAbleToRemove()
		and Duel.IsExistingMatchingCard(s.hifilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(id)~=0 or not c:IsAbleToRemove() then return end
	local hg=Duel.GetMatchingGroup(s.hifilter,tp,LOCATION_MZONE,0,nil)
	if #hg==0 or not Duel.SelectEffectYesNo(tp,c,aux.Stringid(id,0)) then return end
	c:RegisterFlagEffect(id,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=hg:Select(tp,1,1,nil)
	local g=Group.FromCards(c)
	g:Merge(sg)
	if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		g:KeepAlive()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_SOLVED)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetLabelObject(g)
		e1:SetOperation(s.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g then return end
	local rg=g:Filter(Card.IsLocation,nil,LOCATION_REMOVED)
	g:DeleteGroup()
	if #rg>0 then
		for tc in aux.Next(rg) do
			Duel.ReturnToField(tc)
		end
	end
	--"and if you do" (both returned): you can banish 2 cards from opponent's field/GY
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_MZONE) then return end
	local bg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_ONFIELD+LOCATION_GRAVE,nil)
	if #bg>0 and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local ct=math.min(2,#bg)
		local sg=bg:Select(tp,ct,ct,nil)
		Duel.HintSelection(sg)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	end
end
--(2)
function s.discol(e,c)
	return e:GetHandler():GetColumnGroup():IsContains(c)
end
