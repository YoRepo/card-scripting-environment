--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 核心爆破  (ID: 18517177)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己的准备阶段时只有1次，对方场上存在的怪兽数量比自己多的场合，可以直到变成和自己场上存在的怪兽数量相同数量为止把对方场上存在的卡破坏。这个效果在自己场上有名字带有「核成」的怪兽表侧表示存在的场合才能
-- 发动。
--[[ __CARD_HEADER_END__ ]]

--コア・ブラスト
function c18517177.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--maintain
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(18517177,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c18517177.descon)
	e2:SetTarget(c18517177.destg)
	e2:SetOperation(c18517177.desop)
	c:RegisterEffect(e2)
end
function c18517177.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1d)
end
function c18517177.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
		and Duel.IsExistingMatchingCard(c18517177.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c18517177.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)-Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,ct,0,0)
end
function c18517177.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	local ct=g:GetCount()-Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	if ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=g:Select(tp,ct,ct,nil)
	Duel.Destroy(dg,REASON_EFFECT)
end
