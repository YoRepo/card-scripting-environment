--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Number 7: Lucky Straight  (ID: 82308875)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank: 7
-- ATK 700 | DEF 700
-- Setcode: 0x48
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3 Level 7 monsters
-- You can detach 1 Xyz Material from this card; roll a six-sided die twice and this card's ATK becomes
-- the larger number rolled x 700 until your opponent's next End Phase, then if the total roll was
-- exactly 7, apply 1 of these effects.
-- ● Send all other cards on the field to the Graveyard.
-- ● Special Summon 1 monster from your hand or from either Graveyard.
-- ● Draw 3 cards, then discard 2 cards.
--[[ __CARD_HEADER_END__ ]]

--No.7 ラッキー・ストライプ
function c82308875.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82308875,0))
	e1:SetCategory(CATEGORY_DICE|CATEGORY_ATKCHANGE|CATEGORY_DRAW|CATEGORY_SPECIAL_SUMMON|CATEGORY_TOGRAVE|CATEGORY_HANDES_SELF)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c82308875.cost)
	e1:SetTarget(c82308875.target)
	e1:SetOperation(c82308875.operation)
	c:RegisterEffect(e1)
end
aux.xyz_number[82308875]=7
function c82308875.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c82308875.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,2)
end
function c82308875.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c82308875.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d1,d2=Duel.TossDice(tp,2)
	if d2>d1 then d1,d2=d2,d1 end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(d1*700)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
	c:RegisterEffect(e1)
	if d1+d2==7 then
		local b1=Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,LOCATION_ONFIELD)>1
		local spg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c82308875.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,LOCATION_GRAVE,nil,e,tp)
		local b2=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and spg:GetCount()>0
		local b3=Duel.IsPlayerCanDraw(tp,3)
		if not b1 and not b2 and not b3 then return end
		local op=0
		if b1 and not b2 and not b3 then op=Duel.SelectOption(tp,aux.Stringid(82308875,1))
		elseif not b1 and b2 and not b3 then op=Duel.SelectOption(tp,aux.Stringid(82308875,2))+1
		elseif not b1 and not b2 and b3 then op=Duel.SelectOption(tp,aux.Stringid(82308875,3))+2
		elseif b1 and b2 and not b3 then op=Duel.SelectOption(tp,aux.Stringid(82308875,1),aux.Stringid(82308875,2))
		elseif b1 and not b2 and b3 then op=Duel.SelectOption(tp,aux.Stringid(82308875,1),aux.Stringid(82308875,3)) if op==1 then op=2 end
		elseif not b1 and b2 and b3 then op=Duel.SelectOption(tp,aux.Stringid(82308875,2),aux.Stringid(82308875,3))+1
		else op=Duel.SelectOption(tp,aux.Stringid(82308875,1),aux.Stringid(82308875,2),aux.Stringid(82308875,3)) end
		if op==0 then
			local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
			Duel.SendtoGrave(g,REASON_EFFECT)
		elseif op==1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=spg:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.Draw(tp,3,REASON_EFFECT)
			Duel.BreakEffect()
			Duel.DiscardHand(tp,aux.TRUE,2,2,REASON_EFFECT+REASON_DISCARD)
		end
	end
end
