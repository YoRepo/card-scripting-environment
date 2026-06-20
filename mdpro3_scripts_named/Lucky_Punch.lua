--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 幸运拳  (ID: 36378044)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 1回合1次，对方怪兽的攻击宣言时才能发动。进行3次投掷硬币，3次都是表的场合，自己从卡组抽3张卡。3次都是里的场合，这张卡破坏。此外，场上表侧表示存在的这张卡被破坏的场合，自己失去6000基本分。
--[[ __CARD_HEADER_END__ ]]

--ラッキーパンチ
function c36378044.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--coin
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36378044,0))
	e2:SetCategory(CATEGORY_DRAW+CATEGORY_DESTROY+CATEGORY_COIN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c36378044.atkcon)
	e2:SetTarget(c36378044.atktg)
	e2:SetOperation(c36378044.atkop)
	c:RegisterEffect(e2)
	--life lost
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c36378044.descon)
	e3:SetOperation(c36378044.desop)
	c:RegisterEffect(e3)
end
function c36378044.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c36378044.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c36378044.atkop(e,tp,eg,ep,ev,re,r,rp)
	local r1,r2,r3=Duel.TossCoin(tp,3)
	if r1+r2+r3==3 then
		Duel.Draw(tp,3,REASON_EFFECT)
	elseif r1+r2+r3==0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c36378044.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
end
function c36378044.desop(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(tp)
	Duel.SetLP(tp,lp-6000)
end
