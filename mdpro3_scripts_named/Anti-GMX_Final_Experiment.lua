--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 对GMX最终试验  (ID: 1463589)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 477
--
-- Effect Text:
-- 自己场上有「GMX」怪兽存在的场合才能把这张卡发动。
-- 1回合1次，对方把怪兽的效果在场上发动时（伤害步骤除外）：可以从自己卡组上面把5张卡翻开，那之后，翻到「GMX」卡的场合，那个发动的效果无效，翻开的卡用喜欢的顺序回到卡组上面或下面。
--[[ __CARD_HEADER_END__ ]]

--Anti-GMX Final Experiment
local s,id,o=GetID()
function s.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetCondition(s.actcon)
	c:RegisterEffect(e0)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.negcon)
	e1:SetTarget(s.negtg)
	e1:SetOperation(s.negop)
	c:RegisterEffect(e1)
end
function s.gmxm(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x1dd)
end
function s.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.gmxm,tp,LOCATION_MZONE,0,1,nil,tp)
end
function s.negcon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return ep~=tp and loc==LOCATION_MZONE and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainDisablable(ev)
end
function s.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5 end
end
function s.gmxfilter(c)
	return c:IsSetCard(0x1dd)
end
function s.negop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,5)
	if g:GetCount()==0 then return end
	Duel.ConfirmDecktop(tp,5)
	if e:GetHandler():IsSetCard(0x1dd) then
		Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+1595137,e,0,tp,tp,0)
	end
	Duel.BreakEffect()
	local flag=g:IsExists(s.gmxfilter,1,nil)
	if flag then Duel.NegateEffect(ev) end
	local ct=g:GetCount()
	local op=Duel.SelectOption(tp,aux.Stringid(id,1),aux.Stringid(id,2))
	Duel.SortDecktop(tp,tp,ct)
	if op==0 then return end
	for i=1,ct do
		local mg=Duel.GetDecktopGroup(tp,1)
		Duel.MoveSequence(mg:GetFirst(),SEQ_DECKBOTTOM)
	end
end
