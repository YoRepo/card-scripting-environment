--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 一击推进士  (ID: 60187739)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己对怪兽的召唤成功的回合，这张卡可以从手卡特殊召唤。可以把这张卡解放，这个回合和自己怪兽进行战斗的1只对方怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ワンショット・ブースター
function c60187739.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c60187739.spcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60187739,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c60187739.cost)
	e2:SetTarget(c60187739.target)
	e2:SetOperation(c60187739.operation)
	c:RegisterEffect(e2)
	if not c60187739.global_check then
		c60187739.global_check=true
		c60187739[0]=false
		c60187739[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c60187739.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c60187739.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c60187739.checkop(e,tp,eg,ep,ev,re,r,rp)
	c60187739[ep]=true
end
function c60187739.clear(e,tp,eg,ep,ev,re,r,rp)
	c60187739[0]=false
	c60187739[1]=false
end
function c60187739.spcon(e,c)
	if c==nil then return true end
	return c60187739[c:GetControler()] and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c60187739.filter(c)
	return c:IsFaceup() and c:GetBattledGroupCount()~=0
end
function c60187739.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c60187739.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c60187739.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60187739.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c60187739.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c60187739.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
