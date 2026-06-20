--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 外星人复仇者  (ID: 63253763)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Reptile
-- Level 6
-- ATK 2200 | DEF 1600
-- Setcode: 12
--
-- Effect Text:
-- 这张卡可以把场上存在的2个A指示物取除，从手卡特殊召唤。1回合1次，可以给对方场上表侧表示存在的全部怪兽放置1个A指示物。有A指示物放置的怪兽和名字带有「外星」的怪兽战斗的场合，每有1个A指示物攻击力
-- ·守备力下降300。「外星人复仇者」在自己场上只能有1只表侧表示存在。
--[[ __CARD_HEADER_END__ ]]

--エーリアン・リベンジャー
function c63253763.initial_effect(c)
	c:SetUniqueOnField(1,0,63253763)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c63253763.spcon)
	e1:SetOperation(c63253763.spop)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(63253763,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c63253763.cttg)
	e2:SetOperation(c63253763.ctop)
	c:RegisterEffect(e2)
	--atk def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCondition(c63253763.adcon)
	e3:SetTarget(c63253763.adtg)
	e3:SetValue(c63253763.adval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end
c63253763.counter_add_list={0x100e}
function c63253763.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsCanRemoveCounter(c:GetControler(),1,1,0x100e,2,REASON_COST)
end
function c63253763.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.RemoveCounter(tp,1,1,0x100e,2,REASON_COST)
end
function c63253763.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsCanAddCounter,tp,0,LOCATION_MZONE,1,nil,0x100e,1) end
end
function c63253763.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsCanAddCounter,tp,0,LOCATION_MZONE,nil,0x100e,1)
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x100e,1)
		tc=g:GetNext()
	end
end
function c63253763.adcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and Duel.GetAttackTarget()
end
function c63253763.adtg(e,c)
	local bc=c:GetBattleTarget()
	return bc and c:GetCounter(0x100e)~=0 and bc:IsSetCard(0xc)
end
function c63253763.adval(e,c)
	return c:GetCounter(0x100e)*-300
end
