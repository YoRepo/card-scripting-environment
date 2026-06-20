--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 锁缚龙 锁镰  (ID: 4891376)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 7
-- ATK 2800 | DEF 2100
--
-- Effect Text:
-- 调整＋同调怪兽1只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：把自己场上的这张卡作为同调素材的场合，可以把这张卡当作调整以外的怪兽使用。
-- ②：连锁卡的效果的发动让魔法·陷阱·怪兽的效果发动时，可以从以下效果选择1个发动。
-- ●那个效果无效并破坏。
-- ●那个效果连锁的卡的效果无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--鎖縛竜ザレン
local s,id,o=GetID()
function s.initial_effect(c)
	--synchro summon
	aux.AddSynchroMixProcedure(c,aux.Tuner(nil),nil,nil,aux.FilterBoolFunction(Card.IsSynchroType,TYPE_SYNCHRO),1,99)
	c:EnableReviveLimit()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_MATERIAL_CHECK)
	e0:SetValue(s.valcheck)
	c:RegisterEffect(e0)
	--nontuner
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_NONTUNER)
	e1:SetValue(s.tnval)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.discon)
	e2:SetTarget(s.distg)
	e2:SetOperation(s.disop)
	c:RegisterEffect(e2)
end
function s.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsType,2,nil,TYPE_TUNER) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCode(21142671)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function s.tnval(e,c)
	return e:GetHandler():IsControler(c:GetControler())
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if ev<=1 then return false end
	return not c:IsStatus(STATUS_BATTLE_DESTROYED)
		and (Duel.IsChainDisablable(ev) or Duel.IsChainDisablable(ev-1))
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsChainDisablable(ev)
	local b2=Duel.IsChainDisablable(ev-1)
	if chk==0 then return b1 or b2 end
	local te=Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT)
	local op=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(id,2),1},
		{b2,aux.Stringid(id,3),2})
	e:SetLabel(op)
	if op==1 then
		Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
		if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
			Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
		end
	elseif op==2 then
		Duel.SetOperationInfo(0,CATEGORY_DISABLE,te:GetHandler(),1,0,0)
		if te:GetHandler():IsDestructable() and te:GetHandler():IsRelateToEffect(te) then
			Duel.SetOperationInfo(0,CATEGORY_DESTROY,te:GetHandler(),1,0,0)
		end
	end
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	local op=e:GetLabel()
	if op==1 then
		if Duel.NegateEffect(ev) and re:GetHandler():IsRelateToChain(ev) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
	elseif op==2 then
		local te=Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT)
		if Duel.NegateEffect(ev-1) and te:GetHandler():IsRelateToChain(ev-1) then
			Duel.Destroy(te:GetHandler(),REASON_EFFECT)
		end
	end
end
