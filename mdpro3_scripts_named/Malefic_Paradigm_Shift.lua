--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 罪 范式转移  (ID: 5125629)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 35
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。这张卡也能把基本分支付一半从手卡发动。
-- ①：从自己的卡组·墓地选1张「罪 世界」加入手卡或在自己的场地区域表侧表示放置。那之后，从卡组·额外卡组把1只「罪」怪兽无视召唤条件守备表示特殊召唤。那之后，对方场上有攻击力2500以上的怪兽存在的场
-- 合，对方场上的全部怪兽的攻击力直到回合结束时下降2500。
--[[ __CARD_HEADER_END__ ]]

--Sin Paradigm Shift
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,27564031)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE+CATEGORY_GRAVE_ACTION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DRAW_PHASE,TIMING_DRAW_PHASE+TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,2))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCost(s.cost)
	c:RegisterEffect(e2)
end
function s.thfilter(c,tp)
	return c:IsCode(27564031)
		and (c:IsAbleToHand() or (c:IsType(TYPE_FIELD) and not c:IsForbidden() and c:CheckUniqueOnField(tp)))
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x23) and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACEUP_DEFENSE) and c:IsType(TYPE_MONSTER)
		and (c:IsLocation(LOCATION_DECK) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,tp)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function s.atkfilter(c)
	return c:IsFaceup() and c:IsAttackAbove(2500)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,tp):GetFirst()
	if tc then
		local res=false
		local tfchk=not tc:IsForbidden() and tc:CheckUniqueOnField(tp)
		if tc:IsAbleToHand() and (not tfchk or Duel.SelectOption(tp,1190,aux.Stringid(id,1))==0) then
			if Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
				res=true
				Duel.ConfirmCards(1-tp,tc)
			end
		elseif tfchk then
			local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
			if fc then
				Duel.SendtoGrave(fc,REASON_RULE)
				Duel.BreakEffect()
			end
			res=Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		end
		if res then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp)
			if #g>0 then
				Duel.BreakEffect()
				if Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP_DEFENSE)~=0
					and Duel.IsExistingMatchingCard(s.atkfilter,tp,0,LOCATION_MZONE,1,nil) then
					local sg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
					if #sg>0 then
						Duel.BreakEffect()
						for mc in aux.Next(sg) do
							local e1=Effect.CreateEffect(e:GetHandler())
							e1:SetType(EFFECT_TYPE_SINGLE)
							e1:SetCode(EFFECT_UPDATE_ATTACK)
							e1:SetValue(-2500)
							e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
							mc:RegisterEffect(e1)
						end
					end
				end
			end
		end
	end
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
