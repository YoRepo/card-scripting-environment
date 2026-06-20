--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: No.75 惑乱之风言暗影  (ID: 71166481)
-- Type: Monster / Effect / Xyz
-- Attribute: WIND
-- Race: Spellcaster
-- Rank 3
-- ATK 1000 | DEF 2600
-- Setcode: 72
--
-- Effect Text:
-- 3星怪兽×2只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：1回合1次，对方把怪兽的效果发动时，把这张卡2个超量素材取除才能发动。那个效果变成「双方各自抽1张」。
-- ②：以自己场上1只其他的「No.」超量怪兽为对象才能发动。把这张卡作为那只怪兽的超量素材（这张卡持有超量素材的场合，那些也全部作为超量素材）。
--[[ __CARD_HEADER_END__ ]]

--No.75 惑乱のゴシップ・シャドー
function c71166481.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,3,2,nil,nil,7)
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71166481,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c71166481.chcon)
	e1:SetCost(c71166481.chcost)
	e1:SetTarget(c71166481.chtg)
	e1:SetOperation(c71166481.chop)
	c:RegisterEffect(e1)
	--attach
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(71166481,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,71166481)
	e2:SetTarget(c71166481.xtg)
	e2:SetOperation(c71166481.xop)
	c:RegisterEffect(e2)
end
aux.xyz_number[71166481]=75
function c71166481.chcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and rp==1-tp
end
function c71166481.chcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c71166481.chtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsPlayerCanDraw(1-tp,1) end
end
function c71166481.chop(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c71166481.repop)
end
function c71166481.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
function c71166481.xfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48)
end
function c71166481.xtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c71166481.xfilter(chkc) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c71166481.xfilter,tp,LOCATION_MZONE,0,1,c)
		and c:IsCanOverlay() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c71166481.xfilter,tp,LOCATION_MZONE,0,1,1,c)
end
function c71166481.xop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and c:IsCanOverlay() then
		local mg=c:GetOverlayGroup()
		if mg:GetCount()>0 then Duel.Overlay(tc,mg,false) end
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
