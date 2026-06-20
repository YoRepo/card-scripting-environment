--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 肃声的龙贤圣 始龙  (ID: 88284599)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 7
-- ATK 2600 | DEF 2800
-- Setcode: 422
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：这张卡可以从自己的手卡·墓地让包含仪式魔法卡的2张魔法卡回到卡组，从手卡特殊召唤。
-- ②：对方把卡的效果发动时，让场上的这张卡回到手卡才能发动。从手卡·卡组把1只战士族·龙族而光属性的仪式怪兽特殊召唤。这个效果特殊召唤的怪兽在下个回合的结束阶段回到卡组。
--[[ __CARD_HEADER_END__ ]]

--粛声の竜賢聖サウラヴィス
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.sprcon)
	e1:SetOperation(s.sprop)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.con)
	e2:SetCost(s.cost)
	e2:SetTarget(s.target)
	e2:SetOperation(s.operation)
	c:RegisterEffect(e2)
end
function s.sprfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToDeckAsCost()
end
function s.gcheck(g)
	return g:IsExists(Card.IsType,1,nil,TYPE_RITUAL)
end
function s.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(s.sprfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,nil)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and g:CheckSubGroup(s.gcheck,2,2)
end
function s.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(s.sprfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local sg=g:SelectSubGroup(tp,s.gcheck,false,2,2)
	local hg=sg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	if #hg>0 then
		Duel.ConfirmCards(1-tp,hg)
	end
	local gg=sg:Filter(Card.IsLocation,nil,LOCATION_GRAVE)
	if #gg>0 then
		Duel.HintSelection(gg)
	end
	Duel.SendtoDeck(sg,nil,2,REASON_COST)
end
function s.con(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToHandAsCost() end
	Duel.SendtoHand(c,nil,REASON_COST)
end
function s.filter(c,e,tp)
	return c:IsRace(RACE_DRAGON+RACE_WARRIOR) and c:IsType(TYPE_RITUAL) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsCanBeSpecialSummoned(e,0,tp,false,true)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local sc=g:GetFirst()
		if Duel.SpecialSummonStep(sc,0,tp,tp,false,true,POS_FACEUP) then
			sc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,2)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetLabelObject(sc)
			e1:SetCondition(s.tdcon)
			e1:SetOperation(s.tdop)
			e1:SetReset(RESET_PHASE+PHASE_END,2)
			Duel.RegisterEffect(e1,tp)
		end
		Duel.SpecialSummonComplete()
	end
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnCount()~=e:GetLabel() and tc:GetFlagEffect(id)~=0
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,id)
	local tc=e:GetLabelObject()
	Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
