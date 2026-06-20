--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: No.7 幸运条纹人  (ID: 82308875)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Fairy
-- Rank 7
-- ATK 700 | DEF 700
-- Setcode: 72
--
-- Effect Text:
-- 7星怪兽×3
-- ①：把这张卡1个超量素材取除才能发动。掷2次骰子。这张卡的攻击力直到对方回合结束时变成较大方的出现数目×700。出现的数目合计是7的场合，再从以下效果选1个适用。
-- ●这张卡以外的场上的卡全部送去墓地。
-- ●从手卡或者自己·对方的墓地选1只怪兽在自己场上特殊召唤。
-- ●自己从卡组抽3张，那之后选2张手卡丢弃。
--[[ __CARD_HEADER_END__ ]]

--No.7 ラッキー・ストライプ
function c82308875.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82308875,0))
	e1:SetCategory(CATEGORY_DICE|CATEGORY_ATKCHANGE|CATEGORY_DRAW|CATEGORY_SPECIAL_SUMMON|CATEGORY_TOGRAVE)
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
