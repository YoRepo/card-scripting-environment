--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 幻影骑士团 无声靴  (ID: 36426778)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 3
-- ATK 200 | DEF 1200
-- Setcode: 4315
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有「幻影骑士团」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：把墓地的这张卡除外才能发动。从卡组把1张「幻影」魔法·陷阱卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--幻影騎士団サイレントブーツ
function c36426778.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(36426778,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,36426778+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c36426778.spcon)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(36426778,1))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,36426779)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c36426778.thtg)
	e2:SetOperation(c36426778.thop)
	c:RegisterEffect(e2)
end
function c36426778.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x10db)
end
function c36426778.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c36426778.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c36426778.thfilter(c)
	return c:IsSetCard(0xdb) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c36426778.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c36426778.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c36426778.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c36426778.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
