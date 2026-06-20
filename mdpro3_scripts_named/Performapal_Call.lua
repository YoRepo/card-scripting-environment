--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 娱乐伙伴呼唤  (ID: 22765132)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 159
--
-- Effect Text:
-- ①：对方怪兽的直接攻击宣言时，以那1只攻击怪兽为对象才能发动。那次攻击无效，守备力合计最多到作为对象的怪兽的攻击力以下为止，从卡组把最多2只「娱乐伙伴」怪兽加入手卡。这张卡的发动后，直到下次的自己回合
-- 的结束时自己不能从额外卡组把怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--EMコール
function c22765132.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c22765132.condition)
	e1:SetTarget(c22765132.target)
	e1:SetOperation(c22765132.activate)
	c:RegisterEffect(e1)
end
function c22765132.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c22765132.filter(c,def)
	return c:IsSetCard(0x9f) and c:IsDefenseBelow(def) and c:IsAbleToHand()
end
function c22765132.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	if chkc then return chkc==at end
	if chk==0 then return at:IsOnField() and at:IsCanBeEffectTarget(e)
		and Duel.IsExistingMatchingCard(c22765132.filter,tp,LOCATION_DECK,0,1,nil,at:GetAttack()) end
	Duel.SetTargetCard(at)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c22765132.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.NegateAttack() then
		local val=tc:GetAttack()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g1=Duel.SelectMatchingCard(tp,c22765132.filter,tp,LOCATION_DECK,0,1,1,nil,val)
		local sc=g1:GetFirst()
		if sc then
			val=val-sc:GetDefense()
			if Duel.IsExistingMatchingCard(c22765132.filter,tp,LOCATION_DECK,0,1,sc,val)
				and Duel.SelectYesNo(tp,aux.Stringid(22765132,0)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local g2=Duel.SelectMatchingCard(tp,c22765132.filter,tp,LOCATION_DECK,0,1,1,sc,val)
				g1:Merge(g2)
			end
			Duel.SendtoHand(g1,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g1)
		end
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c22765132.sumlimit)
		if Duel.GetTurnPlayer()==tp then
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c22765132.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
