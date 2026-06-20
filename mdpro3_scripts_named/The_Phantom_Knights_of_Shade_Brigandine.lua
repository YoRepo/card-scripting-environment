--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 幻影骑士团 阴暗布面甲  (ID: 98827725)
-- Type: Trap
-- Attribute: DARK
-- Race: Warrior
-- Level 4
-- ATK 0 | DEF 300
-- Setcode: 4315
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。自己墓地没有陷阱卡存在的场合，这张卡在盖放的回合也能发动。
-- ①：这张卡发动后变成通常怪兽（战士族·暗·4星·攻0/守300）在怪兽区域守备表示特殊召唤（不当作陷阱卡使用）。
--[[ __CARD_HEADER_END__ ]]

--幻影騎士団シェード・ブリガンダイン
function c98827725.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,98827725+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c98827725.target)
	e1:SetOperation(c98827725.activate)
	c:RegisterEffect(e1)
	--act in set turn
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(98827725,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCondition(c98827725.actcon)
	c:RegisterEffect(e2)
end
function c98827725.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,98827725,0x10db,TYPES_NORMAL_TRAP_MONSTER,0,300,4,RACE_WARRIOR,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c98827725.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.IsPlayerCanSpecialSummonMonster(tp,98827725,0x10db,TYPES_NORMAL_TRAP_MONSTER,0,300,4,RACE_WARRIOR,ATTRIBUTE_DARK) then
		c:AddMonsterAttribute(TYPE_NORMAL)
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	end
end
function c98827725.actcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,TYPE_TRAP)
end
