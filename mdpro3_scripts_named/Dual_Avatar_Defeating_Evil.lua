--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Dual Avatar Defeating Evil  (ID: 49158617)
-- Type: Spell / Quick-Play
-- Setcode: 0x14f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Target 1 "Dual Avatar" monster you control and 1 card your opponent controls; destroy them, then if
-- you destroyed a "Dual Avatar" Fusion Monster you control by this effect, you can apply 1 of these
-- effects.
-- ● Draw 1 card.
-- ● Banish 1 card from your opponent's GY.
-- You can only activate 1 "Dual Avatar Defeating Evil" per turn.
--[[ __CARD_HEADER_END__ ]]

--双天の調伏
function c49158617.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW+CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,49158617+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c49158617.target)
	e1:SetOperation(c49158617.activate)
	c:RegisterEffect(e1)
end
function c49158617.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x14f)
end
function c49158617.ffilter(c,tp)
	return c:IsPreviousSetCard(0x14f) and c:IsPreviousControler(tp) and c:GetPreviousTypeOnField()&TYPE_FUSION~=0
		and c:IsPreviousPosition(POS_FACEUP)
end
function c49158617.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c49158617.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c49158617.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_GRAVE)
end
function c49158617.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
		local og=Duel.GetOperatedGroup()
		if og:IsExists(c49158617.ffilter,1,nil,tp) then
			local b1=Duel.IsPlayerCanDraw(tp,1)
			local b2=Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil)
			local off=1
			local ops={}
			local opval={}
			if b1 then
				ops[off]=aux.Stringid(49158617,0)
				opval[off-1]=1
				off=off+1
			end
			if b2 then
				ops[off]=aux.Stringid(49158617,1)
				opval[off-1]=2
				off=off+1
			end
			ops[off]=aux.Stringid(49158617,2)
			opval[off-1]=3
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPTION)
			local op=Duel.SelectOption(tp,table.unpack(ops))
			local sel=opval[op]
			if sel==1 then
				Duel.BreakEffect()
				Duel.Draw(tp,1,REASON_EFFECT)
			elseif sel==2 then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(Card.IsAbleToRemove),tp,0,LOCATION_GRAVE,1,1,nil)
				if #g>0 then
					Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
				end
			end
		end
	end
end
