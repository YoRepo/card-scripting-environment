--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 绝境的狱神域-威利亚  (ID: 99311889)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 462
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：「创狱神 涅瓦」「坏狱神 朱庇特」「调狱神 朱诺拉」各1只从自己的额外卡组·场上（表侧表示）·墓地选出给双方确认，这个回合，对方不能对应自己的「狱神」怪兽的效果的发动把效果发动。
-- ②：为让自己场上的「狱神」怪兽的效果发动而从卡组上面把卡除外的场合，可以作为代替把墓地的这张卡除外。
--[[ __CARD_HEADER_END__ ]]

--絶境なる獄神域－ヴィライア
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,53589300,68231287,5914858)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--change cost
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(id)
	e2:SetCountLimit(1,id+o)
	c:RegisterEffect(e2)
end
function s.cfilter(c,tp)
	return (c:IsLocation(LOCATION_EXTRA) or c:IsFaceupEx()) and c:IsCode(53589300,68231287,5914858)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_EXTRA+LOCATION_MZONE+LOCATION_GRAVE,0,nil,tp)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 and g:CheckSubGroup(aux.dncheck,3,3) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_EXTRA+LOCATION_MZONE+LOCATION_GRAVE,0,nil,tp)
	if Duel.GetFlagEffect(tp,id)==0 and g:CheckSubGroup(aux.dncheck,3,3) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:SelectSubGroup(tp,aux.dncheck,false,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		if sg:IsExists(Card.IsLocation,1,nil,LOCATION_EXTRA) then
			Duel.ShuffleExtra(tp)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetOperation(s.actop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
	end
end
function s.actop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp and re:GetHandler():IsSetCard(0x1ce) and re:IsActiveType(TYPE_MONSTER) then
		Duel.SetChainLimit(s.chainlm)
	end
end
function s.chainlm(e,rp,tp)
	return tp==rp
end
