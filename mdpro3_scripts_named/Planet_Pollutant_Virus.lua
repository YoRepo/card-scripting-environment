--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 惑星污染病毒  (ID: 39163598)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的1只名字带有「外星」的怪兽解放发动。对方场上表侧表示存在的没有A指示物放置的怪兽全部破坏。用对方回合计算的3回合内对方召唤、反转召唤、特殊召唤的怪兽全部放置1个A指示物。
--[[ __CARD_HEADER_END__ ]]

--惑星汚染ウイルス
function c39163598.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1e1)
	e1:SetCost(c39163598.cost)
	e1:SetTarget(c39163598.target)
	e1:SetOperation(c39163598.activate)
	c:RegisterEffect(e1)
end
c39163598.counter_add_list={0x100e}
function c39163598.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0xc) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0xc)
	Duel.Release(g,REASON_COST)
end
function c39163598.tgfilter(c)
	return c:IsFaceup() and c:GetCounter(0x100e)==0
end
function c39163598.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c39163598.tgfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c39163598.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c39163598.tgfilter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c39163598.ctop1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,3)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c39163598.ctop2)
	Duel.RegisterEffect(e3,tp)
end
function c39163598.ctop1(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then
		eg:GetFirst():AddCounter(0x100e,1)
	end
end
function c39163598.ctop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:IsSummonPlayer(1-tp) then
			tc:AddCounter(0x100e,1)
		end
		tc=eg:GetNext()
	end
end
