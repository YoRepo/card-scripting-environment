--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 莫忘哥布林  (ID: 17943271)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 400 | DEF 400
-- Setcode: 11272609
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，自己场上有「冥骸合龙-莫忘冥地王灵」存在的场合，把这张卡从手卡丢弃才能发动。这个回合中，对方不能把自己场上的「莫忘」怪兽作为效果的对象。
-- ②：自己主要阶段才能发动。自己场上1只「莫忘」怪兽破坏，从卡组把「莫忘哥布林」以外的最多2张「莫忘」卡送去墓地（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--メメント・ゴブリン
local s,id,o=GetID()
function s.initial_effect(c)
	--limit targeting
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCondition(s.ltcon)
	e1:SetCost(s.ltcost)
	e1:SetOperation(s.ltop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.tgtg)
	e2:SetOperation(s.tgop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and c:IsCode(23288411)
end
function s.ltcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
		and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function s.ltcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function s.ltop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1a1))
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(aux.tgoval)
	Duel.RegisterEffect(e1,tp)
end
function s.dfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1a1)
end
function s.filter(c)
	return c:IsSetCard(0x1a1) and c:IsAbleToGrave() and not c:IsCode(id)
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.dfilter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return #g>0 and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,s.dfilter,tp,LOCATION_MZONE,0,1,1,nil)
	if Duel.Destroy(g,REASON_EFFECT)<1 then return end
	local tg=Duel.GetMatchingGroup(s.filter,tp,LOCATION_DECK,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=tg:SelectSubGroup(tp,aux.dncheck,false,1,2)
	if sg then Duel.SendtoGrave(sg,REASON_EFFECT) end
end
