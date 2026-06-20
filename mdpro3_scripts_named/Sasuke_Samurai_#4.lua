--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 一击必杀侍  (ID: 64538655)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 1200
--
-- Effect Text:
-- ①：这张卡和对方怪兽进行战斗的伤害步骤开始时发动。进行1次投掷硬币，对里表作猜测。猜中的场合，那只对方怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--一撃必殺侍
function c64538655.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64538655,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c64538655.descon)
	e1:SetTarget(c64538655.destg)
	e1:SetOperation(c64538655.desop)
	c:RegisterEffect(e1)
end
function c64538655.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c64538655.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c64538655.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if c==tc then tc=Duel.GetAttacker() end
	if not tc:IsRelateToBattle() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
	local coin=Duel.AnnounceCoin(tp)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
