--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 治安战警队桥头堡  (ID: 23377425)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 342
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这个卡名的②的效果1回合只能使用1次。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把1只「治安战警队」怪兽加入手卡。
-- ②：对方怪兽向相同纵列的自己的「治安战警队」怪兽攻击宣言时才能发动。那只自己怪兽不会被那次战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--S－Force ブリッジヘッド
function c23377425.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,23377425+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c23377425.activate)
	c:RegisterEffect(e1)
	--indes battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23377425,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,23377426)
	e2:SetCondition(c23377425.indcon)
	e2:SetTarget(c23377425.indtg)
	e2:SetOperation(c23377425.indop)
	c:RegisterEffect(e2)
end
function c23377425.thfilter(c)
	return c:IsSetCard(0x156) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c23377425.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c23377425.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(23377425,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c23377425.indcon(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	local cg=ac:GetColumnGroup()
	e:SetLabelObject(bc)
	return ac:IsControler(1-tp) and cg:IsContains(bc) and bc:IsFaceup() and bc:IsSetCard(0x156) and bc:IsControler(tp)
end
function c23377425.indtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return bc and bc:IsRelateToBattle() end
end
function c23377425.indop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc and bc:IsRelateToBattle() and bc:IsControler(tp) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		bc:RegisterEffect(e1)
	end
end
