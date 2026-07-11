--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Wandering Mummy  (ID: 42994702)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Zombie
-- Level: 4
-- ATK 1500 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can flip this card into face-down Defense Position once per turn during your Main Phase.
-- After you use this effect, rearrange the face-down Defense Position monsters in your Main Monster
-- Zones, then return them in face-down Defense Position.
--[[ __CARD_HEADER_END__ ]]

--さまようミイラ
function c42994702.initial_effect(c)
	--turn set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42994702,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c42994702.target)
	e1:SetOperation(c42994702.operation)
	c:RegisterEffect(e1)
end
function c42994702.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(42994702)==0 end
	c:RegisterFlagEffect(42994702,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c42994702.filter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c42994702.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)>0 then
		local g=Duel.GetMatchingGroup(c42994702.filter,tp,LOCATION_MZONE,0,nil)
		Duel.ShuffleSetCard(g)
	end
end
