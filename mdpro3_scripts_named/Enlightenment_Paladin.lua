--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 觉醒之魔导剑士  (ID: 59123194)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Spellcaster
-- Level 8
-- ATK 2500 | DEF 2000
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 「觉醒之魔导剑士」的①的效果1回合只能使用1次。
-- ①：「魔术师」灵摆怪兽作为素材让这张卡同调召唤成功的场合，以自己墓地1张魔法卡为对象才能发动。那张卡加入手卡。
-- ②：这张卡战斗破坏对方怪兽时才能发动。给与对方那只怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--覚醒の魔導剣士
function c59123194.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,59123194)
	e1:SetCondition(c59123194.thcon)
	e1:SetTarget(c59123194.thtg)
	e1:SetOperation(c59123194.thop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c59123194.damtg)
	e2:SetOperation(c59123194.damop)
	c:RegisterEffect(e2)
end
function c59123194.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_SYNCHRO) and c:GetMaterial():IsExists(c59123194.pmfilter,1,nil)
end
function c59123194.thfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c59123194.pmfilter(c)
	return c:IsSetCard(0x98) and c:IsType(TYPE_PENDULUM)
end
function c59123194.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c59123194.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c59123194.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c59123194.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c59123194.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c59123194.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	local dam=bc:GetTextAttack()
	if chk==0 then return dam>0 end
	Duel.SetTargetCard(bc)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c59123194.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
		local dam=tc:GetTextAttack()
		if dam<0 then dam=0 end
		Duel.Damage(p,dam,REASON_EFFECT)
	end
end
