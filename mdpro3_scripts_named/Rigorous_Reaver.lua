--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 再造的死神  (ID: 39180960)
-- Type: Monster / Effect / Toon
-- Attribute: FIRE
-- Race: Plant
-- Level 3
-- ATK 1600 | DEF 100
--
-- Effect Text:
-- ①：这张卡反转的场合发动。双方玩家各自选自己1张手卡丢弃。
-- ②：这张卡被和怪兽的战斗破坏的场合发动。那只怪兽的攻击力·守备力下降500。
--[[ __CARD_HEADER_END__ ]]

--リグラス・リーパー
function c39180960.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39180960,0))
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c39180960.target)
	e1:SetOperation(c39180960.operation)
	c:RegisterEffect(e1)
	--destroyed
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39180960,1))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetOperation(c39180960.desop)
	c:RegisterEffect(e2)
end
function c39180960.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,1)
end
function c39180960.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g1=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
	local g2=Duel.SelectMatchingCard(1-tp,aux.TRUE,1-tp,LOCATION_HAND,0,1,1,nil)
	g1:Merge(g2)
	Duel.SendtoGrave(g1,REASON_DISCARD+REASON_EFFECT)
end
function c39180960.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if c==tc then tc=Duel.GetAttackTarget() end
	if not tc:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(-500)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	tc:RegisterEffect(e2)
end
