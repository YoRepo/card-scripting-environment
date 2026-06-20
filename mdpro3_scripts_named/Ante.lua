--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 打赌胜负  (ID: 34236961)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方各自选择1张手卡并展示，相互确认等级。选择等级较高卡的一方将选出的卡放回手卡，选择等级较低卡的一方受到1000点伤害，将选出的卡送去墓地。选择怪兽卡以外的卡时，等级强制计为0。双方选择的卡等级相同
-- 时，各自将选出的卡放回手卡。
--[[ __CARD_HEADER_END__ ]]

--アンティ勝負
function c34236961.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c34236961.target)
	e1:SetOperation(c34236961.activate)
	c:RegisterEffect(e1)
end
function c34236961.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local h1=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
		if e:GetHandler():IsLocation(LOCATION_HAND) then h1=h1-1 end
		local h2=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
		return (h1>0 and h2>0)
	end
end
function c34236961.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 or Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONFIRM)
	local g2=Duel.SelectMatchingCard(1-tp,nil,1-tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g1)
	Duel.ConfirmCards(tp,g2)
	local atpsl=g1:GetFirst()
	local ntpsl=g2:GetFirst()
	local atplv=atpsl:IsType(TYPE_MONSTER) and atpsl:GetLevel() or 0
	local ntplv=ntpsl:IsType(TYPE_MONSTER) and ntpsl:GetLevel() or 0
	if atplv==ntplv then
		Duel.ShuffleHand(tp)
		Duel.ShuffleHand(1-tp)
	elseif atplv>ntplv then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
		Duel.SendtoGrave(g2,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	else
		Duel.Damage(tp,1000,REASON_EFFECT)
		Duel.SendtoGrave(g1,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
