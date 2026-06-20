--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 影依的原核  (ID: 4904633)
-- Type: Trap / Equip
-- Attribute: DARK
-- Race: Spellcaster
-- Level 9
-- ATK 1450 | DEF 1950
-- Setcode: 157
--
-- Effect Text:
-- ①：这张卡发动后变成效果怪兽（魔法师族·暗·9星·攻1450/守1950）在怪兽区域特殊召唤。把这个效果特殊召唤的这张卡作为「影依」融合怪兽的融合素材的场合，可以作为那张卡记述的属性的融合素材怪兽的代
-- 替。这张卡也当作陷阱卡使用。
-- ②：这张卡被效果送去墓地的场合，以「影依的原核」以外的自己墓地1张「影依」魔法·陷阱卡为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--影依の原核
function c4904633.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c4904633.target)
	e1:SetOperation(c4904633.activate)
	c:RegisterEffect(e1)
	--attribute substitute
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(4904633)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCondition(c4904633.condition)
	c:RegisterEffect(e0)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(4904633,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCondition(c4904633.thcon)
	e2:SetTarget(c4904633.thtg)
	e2:SetOperation(c4904633.thop)
	c:RegisterEffect(e2)
end
function c4904633.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,4904633,0,TYPES_EFFECT_TRAP_MONSTER,1450,1950,9,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c4904633.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,4904633,0,TYPES_EFFECT_TRAP_MONSTER,1450,1950,9,RACE_SPELLCASTER,ATTRIBUTE_DARK) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TRAP)
	Duel.SpecialSummon(c,SUMMON_VALUE_SELF,tp,tp,true,false,POS_FACEUP)
end
function c4904633.condition(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
function c4904633.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_EFFECT)
end
function c4904633.thfilter(c)
	return c:IsSetCard(0x9d) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(4904633) and c:IsAbleToHand()
end
function c4904633.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c4904633.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c4904633.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c4904633.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c4904633.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
