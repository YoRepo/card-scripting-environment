--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 剃刀蜥蜴  (ID: 18372968)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Reptile
-- Level 3
-- ATK 1500 | DEF 300
--
-- Effect Text:
-- 只要自己场上有这张卡以外的爬虫类族怪兽表侧表示存在，这张卡攻击里侧守备表示怪兽的场合，不进行伤害计算以里侧守备表示的状态把那只怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--カミソーリトカゲ
function c18372968.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18372968,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c18372968.descon)
	e1:SetTarget(c18372968.destg)
	e1:SetOperation(c18372968.desop)
	c:RegisterEffect(e1)
end
function c18372968.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_REPTILE)
end
function c18372968.descon(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return e:GetHandler()==Duel.GetAttacker() and d and d:IsPosition(POS_FACEDOWN_DEFENSE)
		and Duel.IsExistingMatchingCard(c18372968.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c18372968.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,Duel.GetAttackTarget(),1,0,0)
end
function c18372968.desop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() and d:IsPosition(POS_FACEDOWN_DEFENSE)
		and Duel.IsExistingMatchingCard(c18372968.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) then
		Duel.Destroy(d,REASON_EFFECT)
	end
end
