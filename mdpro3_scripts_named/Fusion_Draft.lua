--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 融合募兵  (ID: 55158350)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 70
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：丢弃1张手卡，把额外卡组1只融合怪兽给对方观看才能发动。除为这个效果发动而丢弃的卡外的1只在给人观看的怪兽有卡名记述的融合素材怪兽从自己的卡组·墓地加入手卡。这个效果把通常怪兽加入手卡的场合，可以
-- 再把另1只加入手卡。这张卡的发动后，直到回合结束时自己不是融合怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--融合募兵
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(s.cost)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_EXTRA,0,1,nil,tp)
		and Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	local exg=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_EXTRA,0,nil,tp)
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
	local og=Duel.GetOperatedGroup()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=exg:Select(tp,1,1,nil)
	Duel.ConfirmCards(1-tp,cg)
	og:Merge(cg)
	e:SetLabelObject(og)
	og:KeepAlive()
end
function s.cfilter(c,tp)
	return c:IsType(TYPE_FUSION) and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,c)
end
function s.thfilter(c,fc)
	return aux.IsMaterialListCode(fc,c:GetCode()) and c:IsAbleToHand()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked() end
	local og=e:GetLabelObject()
	local tc=og:Filter(aux.NOT(Card.IsType),nil,TYPE_FUSION):GetFirst()
	Duel.SetTargetCard(tc)
	local fc=og:Filter(aux.TRUE,tc):GetFirst()
	e:SetLabelObject(fc)
	og:DeleteGroup()
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local nc=Duel.GetFirstTarget()
	local fc=e:GetLabelObject()
	if not nc:IsRelateToChain() then nc=nil end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nc,fc)
	local tc=g:GetFirst()
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsLocation(LOCATION_HAND) and tc:IsType(TYPE_NORMAL)
			and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nc,fc)
			and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nc,fc)
			local tc2=sg:GetFirst()
			if tc2 then
				Duel.BreakEffect()
				Duel.SendtoHand(tc2,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,tc2)
			end
		end
	end
	if not e:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(s.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function s.splimit(e,c)
	return not c:IsType(TYPE_FUSION) and c:IsLocation(LOCATION_EXTRA)
end
