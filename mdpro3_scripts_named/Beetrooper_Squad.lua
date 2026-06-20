--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 骑甲虫步兵分队  (ID: 40633084)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 368
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把衍生物以外的自己场上1只昆虫族怪兽解放才能发动。那只怪兽的原本攻击力每1000最多1只的「骑甲虫衍生物」（昆虫族·地·3星·攻/守1000）在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--騎甲虫歩兵分隊
function c40633084.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40633084,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,40633084+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c40633084.cost)
	e1:SetTarget(c40633084.target)
	e1:SetOperation(c40633084.activate)
	c:RegisterEffect(e1)
end
function c40633084.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return true end
end
function c40633084.cfilter(c,tp)
	return c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_TOKEN) and c:IsRace(RACE_INSECT) and c:GetBaseAttack()>=1000
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c40633084.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c40633084.cfilter,1,nil,tp)
			and Duel.IsPlayerCanSpecialSummonMonster(tp,64213018,0x170,TYPES_TOKEN_MONSTER,1000,1000,3,RACE_INSECT,ATTRIBUTE_EARTH)
	end
	local g=Duel.SelectReleaseGroup(tp,c40633084.cfilter,1,1,nil,tp)
	local atk=g:GetFirst():GetBaseAttack()
	Duel.Release(g,REASON_COST)
	e:SetLabel(math.floor(atk/1000))
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c40633084.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,64213018,0x170,TYPES_TOKEN_MONSTER,1000,1000,3,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	local ct=(Duel.IsPlayerAffectedByEffect(tp,59822133)) and 1 or math.min(ft,e:GetLabel())
	local range={}
	for i=1,ct do
		table.insert(range,i)
	end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(40633084,1))
	local n=Duel.AnnounceNumber(tp,table.unpack(range))
	local sg=Group.CreateGroup()
	for i=1,n do
		local token=Duel.CreateToken(tp,40633085)
		sg:AddCard(token)
	end
	if #sg<=0 then return end
	Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
end
