--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 调和之天救龙  (ID: 70088809)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Dragon
-- Level 7
-- ATK 2500 | DEF 2000
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：对方场上的怪兽把效果发动时，把手卡的这张卡和额外卡组最多5只同调怪兽给对方观看才能发动。给人观看的数量的以下效果全部适用。这个效果的发动后，直到下次的自己回合的结束时，自己不能把同调怪兽以外的从额
-- 外卡组特殊召唤的怪兽的效果发动。
-- ●2只以上：这张卡特殊召唤。
-- ●4只以上：给人观看的同调怪兽之内的1只送去墓地。
-- ●6只：对方场上1只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--調和ノ天救竜
local s,id,o=GetID()
function s.initial_effect(c)
	--sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsActiveType(TYPE_MONSTER) and re:GetActivateLocation()==LOCATION_MZONE
end
function s.cfilter(c)
	return c:IsAllTypes(TYPE_SYNCHRO+TYPE_MONSTER)
end
function s.tgfilter(c)
	return c:IsAbleToGrave()
end
function s.scheck(g)
	return g:GetCount()<3 or g:IsExists(Card.IsAbleToGrave,1,nil)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic()
		and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_EXTRA,0,1,nil) end
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_EXTRA,0,nil)
	local ct=4
	if Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil) then ct=5 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local sg=g:SelectSubGroup(tp,s.scheck,false,1,ct)
	Duel.ConfirmCards(1-tp,sg)
	Duel.ShuffleExtra(tp)
	e:SetLabel(sg:GetCount()+1)
	Duel.SetTargetCard(sg)
	for tc in aux.Next(sg) do
		tc:RegisterFlagEffect(0,RESET_EVENT+RESETS_STANDARD+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(id,1))
	end
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	if e:GetLabel()>5 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY+CATEGORY_TOGRAVE)
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
	elseif e:GetLabel()>3 then
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
	end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	if e:GetLabel()>3 then
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		local tg=g:Filter(Card.IsRelateToChain,nil)
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local og=tg:FilterSelect(tp,Card.IsAbleToGrave,1,1,nil)
			if og:GetCount()>0 then
				Duel.SendtoGrave(og,REASON_EFFECT)
			end
		end
	end
	if e:GetLabel()>5 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(id,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(s.aclimit)
	if Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
	end
	Duel.RegisterEffect(e1,tp)
end
function s.aclimit(e,re,tp)
	local rc=re:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and rc:IsSummonLocation(LOCATION_EXTRA) and rc:IsLocation(LOCATION_MZONE)
		and not rc:IsType(TYPE_SYNCHRO)
end
