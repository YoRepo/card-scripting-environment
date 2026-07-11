--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Kotodama  (ID: 19406822)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level: 3
-- ATK 0 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If there are face-up monsters with the same name on the field, destroy those monsters.
-- (If a monster is Summoned or flipped-face up that has the same name as a monster that is already
-- face-up on the field, the new face-up monster is destroyed. If they are Summoned or flipped face-up
-- at the same time, they are all destroyed.)
--[[ __CARD_HEADER_END__ ]]

--コトダマ
function c19406822.initial_effect(c)
	--adjust
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c19406822.adjustop)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
end
function c19406822.filter(c,g,pg)
	if pg:IsContains(c) then return false end
	local code=c:GetCode()
	return g:IsExists(Card.IsCode,1,c,code) or pg:IsExists(Card.IsCode,1,c,code)
end
function c19406822.adjustop(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()) or phase==PHASE_DAMAGE_CAL then return end
	local c=e:GetHandler()
	local pg=e:GetLabelObject()
	if c:GetFlagEffect(19406822)==0 then
		c:RegisterFlagEffect(19406822,RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,1)
		pg:Clear()
	end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local dg=g:Filter(c19406822.filter,nil,g,e:GetLabelObject())
	if dg:GetCount()==0 or Duel.Destroy(dg,REASON_EFFECT)==0 then
		pg:Clear()
		pg:Merge(g)
		pg:Sub(dg)
	else
		g=Duel.GetMatchingGroup(Card.IsFaceup,0,LOCATION_MZONE,LOCATION_MZONE,nil)
		pg:Clear()
		pg:Merge(g)
		pg:Sub(dg)
		Duel.Readjust()
	end
end
