--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 深红狱呼唤  (ID: 99398682)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己墓地把1只4星以下的恶魔族怪兽加入手卡。自己场上有着「红莲魔龙」或者有那个卡名记述的同调怪兽存在的场合，也能从卡组选加入手卡的怪兽。
-- ②：自己的「/爆裂体」怪兽或「红莲魔龙」攻击的伤害步骤结束时，把墓地的这张卡除外才能发动。那只攻击怪兽只再1次可以继续攻击。
--[[ __CARD_HEADER_END__ ]]

--クリムゾン・ヘルコール
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,70902743)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(s.atkcon)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
end
function s.cfilter(c)
	return c:IsFaceup() and (c:IsCode(70902743) or aux.IsCodeListed(c,70902743) and c:IsType(TYPE_SYNCHRO))
end
function s.thfilter(c,res)
	return c:IsRace(RACE_FIEND) and c:IsLevelBelow(4) and c:IsAbleToHand()
		and (res or not c:IsLocation(LOCATION_DECK))
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local res=Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,res) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,res)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and (tc:IsSetCard(0x104f) or tc:IsCode(70902743)) and tc:IsRelateToBattle()
		and tc:IsChainAttackable()
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
